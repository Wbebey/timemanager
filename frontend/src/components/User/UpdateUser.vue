<template>
  <div>
      <b-card
      bg-variant="dark"
      text-variant="white"
      title="Update User"
    >
      <b-card-text>
        <input v-model="email" placeholder="Entrer l'email"> <br />
        <input v-model="username" placeholder="Entrer le nom d'utilisateur"> <br />
        <input v-model="userID" placeholder="Entrer l'id"> <br />
        <button v-on:click="updateUser()">Update user</button>
      </b-card-text>
    </b-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'UpdateUser',
  data() {
    return {
        username: null,
        email: null,
        userID: null,
    };
  },
  methods: {
    updateUser() {
      axios
        .put(`http://localhost:4000/api/users/${this.userID}/`,
        {
          email: this.email,
          username: this.username,
        })
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("Error", error.message);
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