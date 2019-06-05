<template>
  <div>
    <ul id="nodes">
      <node-item class="item" :model="treeData[0]" :current_node="current_node"></node-item>
    </ul>

    <div class="p-2 mt-4">
      <div class="btn-group">
        <a href="/admin/nodes/new" class="btn btn-sm btn-primary"><i class="fa fa-plus"></i> Ny sida</a>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from "axios";
  import NodeItem from "components/NodeItem";

  export default {
    data: function() {
      return {
        treeData: [{}],
        current_node: null
      };
    },
    components: {
      NodeItem
    },
    methods: {
      close_all: function() {
        this.$store.clearAll();
        this.tree_state = [];
      }
    },
    created: function() {
      axios
        .get("/admin/nodes.json")
        .then(response => {
          this.treeData = response.data;
        })
        .catch(e => {
          this.errors.push(e);
        });
      this.current_node = parseInt($("body").data("currentNode"), 10);
    }
  };
</script>

<style scoped>
  ul {
    list-style-type: none;
    padding: 0;
  }
</style>
