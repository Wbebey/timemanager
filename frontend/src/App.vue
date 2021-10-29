<template>
  <v-app>
    <v-app-bar app color="primary">
      <v-divider />
      <div class="float-left">
        <v-btn value="recent">
          <span>Home</span>

          <v-icon>mdi-history</v-icon>
        </v-btn>

        <v-btn value="favorites">
          <span>Register</span>

          <v-icon>mdi-heart</v-icon>
        </v-btn>

        <v-btn value="nearby">
          <span>About</span>

          <v-icon>mdi-map-marker</v-icon>
        </v-btn>
      </div>
    </v-app-bar>
    <v-main>
      <v-container fluid>
        <router-link to="/">Home </router-link>
        <router-link to="/register">Register </router-link>
        <router-view />
      </v-container>
    </v-main>
    <v-footer>
      <v-card
        flat
        tile
        width="100%"
        color="primary"
        class="lighten-1 text-center"
      >
        <v-card-text class="white--text">
          {{ new Date().getFullYear() }} — <strong>Time Manager</strong>
        </v-card-text>
      </v-card>
    </v-footer>
  </v-app>
</template>

<script>
export default {
  name: "App",
  data: () => ({
    icons: ["mdi-home", "mdi-email", "mdi-calendar", "mdi-delete"],
  }),
};
</script>
