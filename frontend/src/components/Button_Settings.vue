<template>
  <v-dialog width="40vw" height="40vh">
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        class="button-clock-side-elem"
        elevation="2"
        rounded
        text
        x-large
        v-bind="attrs"
        v-on="on"
        color="white"
        ><v-icon dark> mdi-wrench </v-icon></v-btn
      >
    </template>
    <div class="popup">
      <update-user class="update-user" />
    </div>
  </v-dialog>
</template>

<script>
import UpdateUser from "./User/UpdateUser.vue";

export default {
  name: "Button_Settings",
  props: ["title", "body"],
  components: {
    UpdateUser,
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

.update-user {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}
</style>