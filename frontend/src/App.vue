<template>
  <v-app>
    <div v-if="userId == null">
      <p>Is loading</p>
    </div>
    <div v-else-if="userId == 0">
      <app-bar />
    </div>
    <div v-else>
      <p>Welcome enculé numéro {{ userID }}</p>
    </div>
    <router-view />
  </v-app>
</template>

<script>
import AppBar from "./components/AppBar.vue";
import { getCookie } from "./cookie";

export default {
  name: "App",
  components: {
    AppBar,
  },
  data: () => ({
    userId: null,
  }),
  created() {
    let cookie = getCookie("userId");
    if (cookie == "") {
      this.userId = 0;
    } else {
      this.userId = parseInt(cookie, 10);
    }
  },
  methods: {},
};
</script>
