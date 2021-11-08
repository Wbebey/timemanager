<template>
  <div class="text-center">
    <v-dialog v-model="popup" width="70vw" height="60vh">
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="red lighten-2" dark v-bind="attrs" v-on="on">
          Manage User
        </v-btn>
      </template>
      <div class="popup">
        <create-user class="create-user" />
        <manage-user class="modif-user" />
      </div>
    </v-dialog>
  </div>
</template>

<script>
import ManageUser from "./User/ManageUser.vue";
import CreateUser from "./User/CreateUser.vue";

export default {
  popup: null,
  props: ["title", "body"],
  components: {
    ManageUser,
    CreateUser,
  },
  data() {
    return {};
  },
};
</script>

<style scoped>

.popup {
  display: flex;
  flex-direction: row;
}
.create-user {
  width: 42vw;
  height: 55vh;
  display: flex;
}
.modif-user {
  width: 42vw;
  height: 55vh;
  display: flex;
}
</style>