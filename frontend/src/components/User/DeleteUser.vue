<template>
  <div>
      <b-card bg-variant="dark" text-variant="white" title="Delete User">
      <b-card-text>
        <input v-model="userID" placeholder="Entrer l'id" /> <br />
        <br />
        <button v-on:click="deleteUser()">Delete user</button>
      </b-card-text>
    </b-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'DeleteUser',
  data() {
    return {
        userID: null,
    };
  },
  methods: {
    deleteUser() {
        axios
        .delete(
          "http://localhost:4000/api/users/" + this.userID
        )
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => { console.log('Error', error.message); this.info = null;
        });
    },
  },
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