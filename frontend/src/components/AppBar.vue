<template>
  <v-app-bar
    color="#6A76AB"
    dark
    shrink-on-scroll
    prominent
    src="https://picsum.photos/1920/1080?random"
    fade-img-on-scroll
  >
    <template v-slot:img="{ props }">
      <v-img
        v-bind="props"
        gradient="to top right, rgba(100,115,201,.7), rgba(25,32,72,.7)"
      ></v-img>
    </template>

    <v-app-bar-title>Time Manager</v-app-bar-title>

    <v-spacer></v-spacer>

    <template v-slot:extension>
      <v-tabs align-with-title>
        <v-tab @click="ChangeRoute(`/`)">Home</v-tab>
        <v-tab @click="ChangeRoute(`/register`)">Register</v-tab>
        <v-tab @click="ChangeRoute(`/about`)">About</v-tab>
      </v-tabs>
    </template>
  </v-app-bar>
</template>

<script>
export default {
  name: "AppBar",
  components: {},
  data() {
    return {};
  },
  methods: {
    ChangeRoute(path) {
      this.$router.push(path);
    },
  },
};
</script>

<style scoped>
</style>