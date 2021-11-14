<template>
  <v-card class="background-card">
    <v-card-title>
      Dashboard de l'utilisateur {{ store_username }}</v-card-title
    >
    <v-card-text>
      <chart-usermanager />
    </v-card-text>
  </v-card>
</template>

<script>
import ChartUsermanager from "./ChartUserManager.vue";
import store from "../../store";

export default {
  name: "ChartManager",
  data() {
    return {
      store_username: store.state.user.username,
      store_id: store.state.user.id,
    };
  },
  components: {
    ChartUsermanager,
  },
};
</script>

<style scoped>
.background-card {
  width: 100%;
  height: 80vh;
  display: flex;
  flex-direction: column;
  background-color: #3e4c56;
}
</style>