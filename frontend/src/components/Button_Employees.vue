<template>
  <v-dialog width="60vw" height="60vh">
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        class="button-employees"
        elevation="2"
        text
        rounded
        color="white"
        v-bind="attrs"
        v-on="on"
      >
        Employés</v-btn
      >
    </template>
    <div class="popup">
      <manage-user class="modif-user" />
    </div>
  </v-dialog>
</template>

<script>
import ManageUser from "./User/ManageUser.vue";

export default {
  name: "Button_Employees",
  props: ["title", "body"],
  components: {
    ManageUser,
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

</style>