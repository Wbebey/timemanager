<template>
  <v-app>
    <router-view />
  </v-app>
</template>

<script>
export default {
  name: "App",
  components: {},
};
</script>

<style>
@import url('https://fonts.googleapis.com/css?family=Quicksand&display=swap');
* {
  font-family: 'Quicksand', sans-serif;
  color: white;
}
body {
   overflow-y: hidden;
   overflow-x: hidden;
}

</style>
