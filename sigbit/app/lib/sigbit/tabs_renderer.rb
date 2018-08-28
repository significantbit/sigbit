module Sigbit
  class TabsRenderer
    def initialize(template, *args, &block)
      @template = template
      @args = args || []
      @options = args[0] || {}
      @block = block
      @tabs = []
    end

    def rstr
      (0...8).map { ("a".ord + rand(26)).chr }.join
    end

    def render
      @block.call(Context.new(self))
      prepare_tabs
      render_tabs(@tabs) + render_panes(@tabs, @options)
    end

    def prepare_tabs
      @tabs.each.with_index do |tab, index|
        tab.options[:anchor] ||= "tab-#{index}-#{rstr}"
        tab.options[:fade_effect] = false
      end
      active_tab = @tabs.find { |t| t.options[:active] }
      active_tab ||= @tabs.first
      @tabs.each { |t| t.options.delete(:active) }
      active_tab.options[:active] = true if active_tab
    end

    def render_tabs(tabs)
      render_tabs_wrapper do
        tabs.map do |tab|
          render_tab(tab) do
            tab.name
          end
        end.join("\n").html_safe
      end
    end

    def render_panes(tabs, options)
      render_panes_wrapper(options) do
        tabs.map do |tab|
          render_pane(tab) do
            tab.block.call if tab.block
          end
        end.join("\n").html_safe
      end
    end

    ##############

    def render_tabs_wrapper
      content_tag :ul, class: "nav nav-tabs" do
        yield
      end
    end

    def render_tab(tab)
      options = tab.options
      link_class = "nav-link"
      link_class << " active" if options[:active]
      li_class = "nav-item"
      li_class << " #{options[:li_class]}" if options[:li_class]
      content_tag :li, class: li_class do
        link_to "##{options[:anchor]}", data: { toggle: "tab" }, class: link_class do
          yield
        end
      end
    end

    def render_panes_wrapper(options)
      content_class = "tab-content bg-white border-right border-bottom border-left p-2 mb-4 h-100"
      content_class << " #{options[:content_class]}" if options[:content_class]

      content_tag :div, class: content_class do
        yield
      end
    end

    def render_pane(tab)
      options = tab.options
      pane_class = "tab-pane"
      pane_class << " active" if options[:active]
      if options[:fade_effect]
        pane_class << " fade"
        pane_class << " show" if options[:active]
        pane_class << " in" unless options[:active]
      end
      content_tag :div, id: options[:anchor].to_s, class: pane_class, role: "tabpanel" do
        yield
      end
    end

    ####

    def tab(name, options, &block)
      @tabs << Tab.new(name, options, block)
    end

    class Context
      include ActionView::Helpers::TagHelper

      def initialize(renderer)
        @renderer = renderer
      end

      def tab(name, options = {}, &block)
        @renderer.tab(name, options, &block)
      end
    end

    def method_missing(*args, &block)
      @template.send(*args, &block)
    end

    Tab = Struct.new(:name, :options, :block)
  end
end
