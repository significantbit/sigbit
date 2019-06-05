<template>
  <li class="item" :class="{'active': active}">
    <div class="d-flex align-items-center justify-content-start content-container" :class="{'not-published': !model.published}" :data-id="model.id">
      <i class="page-icon fa ml-2 mr-2" :class="model.icon" @click="toggle"></i>
      <span class="page-title mr-2 w-100" @click="toggle" :title="model.title">
        {{ model.title }}
        <span v-if="isFolder">
          <small class="ml-2">
            <i class="fa fa-chevron-right" v-if="!open"></i>
            <i class="fa fa-chevron-down" v-if="open"></i>
          </small>
        </span>
      </span>
      <span class="utility-links d-flex justify-content-end text-white">
        <node-item-actions :model="model"></node-item-actions>
      </span>
    </div>
    <ul v-if="open" style="padding-left:24px">
      <node-item v-for="model in model.children" :model="model" :key="model.id" :current_node="current_node"></node-item>
    </ul>
  </li>
</template>

<script>
  import NodeItem from "./NodeItem";
  import NodeItemActions from "./NodeItemActions";

  export default {
    name: "node-item",
    props: {
      model: Object,
      current_node: Number
    },
    data: function() {
      return {
        open: false
      };
    },
    computed: {
      isFolder: function() {
        return this.model.children && this.model.children.length;
      },
      hasPersistedOpenStatus: function() {
        return this.tree_state.indexOf(this.model.id) !== -1;
      },
      edit_url: function() {
        return "/admin/nodes/" + this.model.id + "/edit";
      },
      delete_url: function() {
        return "/admin/nodes/" + this.model.id;
      },
      add_url: function() {
        return "/admin/nodes/new?parent_id=" + this.model.id;
      },
      active: function() {
        return this.model.id == parseInt(this.current_node, 10);
      }
    },
    methods: {
      toggle: function() {
        if (this.isFolder) {
          this.open = !this.open;
          if (this.open && !this.hasPersistedOpenStatus) {
            this.tree_state.push(this.model.id);
          } else if (!this.open && this.hasPersistedOpenStatus) {
            this.tree_state.splice(this.tree_state.indexOf(this.model.id), 1);
          }
        }
      }
    },
    mounted: function() {
      if (this.hasPersistedOpenStatus || this.model.ancestry == null) {
        this.open = true;
      }
    },
    components: {
      NodeItem,
      NodeItemActions
    }
  };
</script>

<style scoped>
  .item {
    list-style-type: none;
  }

  .item.active > div {
    background-color: rgba(0, 0, 0, 0.3);
  }
  .item > div {
    color: #fff;
  }

  .not-published .page-title,
  .not-published .page-icon {
    color: #e60;
  }

  .page-title {
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
  }
  small {
    font-size: 0.5em;
    position: relative;
    top: -1px;
  }
</style>
