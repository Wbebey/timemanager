<template>
  <div>
    <p>Home View !</p>
    <create-user />
    <get-user />
    <update-user />
    <delete-user />
  </div>
</template>

<script>
import CreateUser from '../components/User/CreateUser.vue'
import GetUser from '../components/User/GetUser.vue'
import DeleteUser from '../components/User/DeleteUser.vue'
import UpdateUser from '../components/User/UpdateUser.vue'

export default {
  name: 'Home',
  components: {
    CreateUser,
    GetUser,
    DeleteUser,
    UpdateUser,
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