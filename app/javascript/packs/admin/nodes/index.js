/* eslint no-console: 0 */
import Vue from 'vue/dist/vue.esm'
import TurbolinksAdapter from 'vue-turbolinks';
import persistentState from 'vue-persistent-state'
import AdminNodesIndex from 'views/admin/nodes/index'
let initialState = { tree_state: [] }

Vue.use(persistentState, initialState)
Vue.use(TurbolinksAdapter)


Vue.config.productionTip = false;

document.addEventListener('turbolinks:load', () => {
  var element = document.getElementById("admin-nodes-index-view")
  if (element != null) {
    const app = new Vue({
      el: element,
      components: {
        'admin-nodes-index-view': AdminNodesIndex
      }
    });
  }
})
