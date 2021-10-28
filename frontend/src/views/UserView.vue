<template>
  <div>
      <p>User View !</p>
      <get-user />
  </div>
</template>

<script>
import GetUser from '../components/User/GetUser.vue'

export default {
  name: 'UserView',
  components: {
    GetUser,
  }
}
</script>

<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>