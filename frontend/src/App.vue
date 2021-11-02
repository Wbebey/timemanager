<template>
  <v-app>
    <v-app-bar app color="primary">
      <v-container>
        <v-row>
          <v-divider />
        </v-row>
        <v-row>
          <v-btn value="recent" @click="ChangeRoute(`/`)">
            <span>Home</span>

            <v-icon>mdi-home</v-icon>
          </v-btn>

          <v-btn value="favorites" @click="ChangeRoute(`/register`)">
            <span>Register</span>

            <v-icon>mdi-account-plus</v-icon>
          </v-btn>

          <v-btn value="nearby" @click="ChangeRoute(`/about`)">
            <span>About</span>

            <v-icon>mdi-information-outline</v-icon>
          </v-btn>
        </v-row>
      </v-container>
    </v-app-bar>
    <v-main>
      <v-container fluid>
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
  methods: {
    ChangeRoute(path) {
      this.$router.push(path);
    }
  },
};
</script>
