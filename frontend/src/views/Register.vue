<template>
  <div>
      <p>Register View !</p>
      <create-user />
  </div>
</template>

<script>
import CreateUser from '../components/User/CreateUser.vue'

export default {
  name: 'Register',
  components: {
    CreateUser
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