<template>
  <div>
    <delete-user /> <br />
    <get-user /> <br />
    <update-user /> <br />
    <delete-user /> <br />
    <get-user /> <br />
    <update-user /> <br />
    <delete-user /> <br />
    <get-user /> <br />
    <update-user /> <br />
  </div>
</template>

<script>
import DeleteUser from '../components/User/DeleteUser.vue'
import GetUser from '../components/User/GetUser.vue'
import UpdateUser from '../components/User/UpdateUser.vue'

  export default {
    name: 'Home',
    components: {
      DeleteUser,
      GetUser,
      UpdateUser,
    },
  }
</script>