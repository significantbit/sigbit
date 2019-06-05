<template>
  <div class="tools">
    <a :href="edit_url" class="btn btn-sm btn-link tool"><i class="fa fa-pencil"></i></a>
    <div class="dropdown">
      <button class="btn btn-sm btn-link text-white" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <i class="fa fa-ellipsis-h fa-lg"></i>
      </button>
      <div class="dropdown-menu dropdown-menu-right tool" aria-labelledby="dropdownMenuButton">
        <a :href="edit_url" class="dropdown-item dropdown-item-sm"><i class="fa fa-fw fa-pencil"></i>Redigera</a>
        <a v-if="not_startpage" @click="togglePublish" class="dropdown-item dropdown-item-sm"><i class="fa fa-fw fa-power-off"></i>{{publish_message}}</a>
        <a :href="add_url" class="dropdown-item dropdown-item-sm" data-turbolinks="false"><i class="fa fa-fw fa-plus"></i>Ny undersida</a>
        <a v-if="not_startpage" :href="delete_url" class="dropdown-item dropdown-item-sm text-danger" data-confirm="Är du säker?" data-method="delete" data-turbolinks="false"><i class="fa fa-fw fa-trash text-danger"></i> Radera sida</a>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from "axios";

  export default {
    name: "node-item-actions",
    props: {
      model: Object
    },
    data: function() {
      return {};
    },
    computed: {
      publish_url: function() {
        return "/admin/nodes/" + this.model.id + "/publish";
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
      publish_message: function() {
        return this.model.published ? "Avpublicera" : "Publicera";
      },
      not_startpage: function() {
        return this.model.ancestry != null;
      }
    },
    methods: {
      togglePublish: function() {
        axios
          .post(this.publish_url)
          .then(response => {
            this.model.published = !this.model.published;
          })
          .catch(e => {
            this.errors.push(e);
          });
      }
    }
  };
</script>

<style scoped>
  .dropdown button,
  .btn.tool {
    position: relative;
    opacity: 0.5;
    transition: all 0.5s;
    background-color: transparent;
    padding: 8px;
  }
  button {
    opacity: 1;
  }
  .tools {
    display: flex;
  }

  .tools .btn.tool i {
    width: auto;
  }
</style>
