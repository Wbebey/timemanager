<template>
  <div id="app">
    <div id="nav">
      <h1>Hello</h1>
      <router-link to="/">Home</router-link>
      <router-link to="/workingTimes/:userId">Component WorkingTimes</router-link>
      <router-link to="/workingTime/:userId">Component WorkingTime</router-link>
      <router-link to="/workingTime/:userId/:workingtimeId">Component WorkingTime</router-link>
      <router-link to="/clock/:username">Component Clock</router-link>
      <router-link to="/chartManager/:userid">Component ChartManager</router-link>
    </div>
    <router-view/>
  </div>
</template>


<script>
export default {
 name: 'Home',
 data() {
    return {
      user: null,
    };
  },
  methods: {
  },
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>
