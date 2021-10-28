<template>
  <div>
    <b-card bg-variant="dark" text-variant="white" title="Get User">
      <b-card-text>
        <input v-model="email" placeholder="Entrer l'email" /> <br />
        <input v-model="username" placeholder="Entrer le nom d'utilisateur" />
        <br />
        <button v-on:click="getUserWithUsernameAndEmail()">Get information user</button>
      </b-card-text>
    </b-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'GetUser',
  data() {
    return {
        email: null,
        username: null,
        userID: null,
    };
  },
  methods: {
    getUserWithID() {
      axios
        .get("http://localhost:4000/api/users/", {
          id: this.userID,
        })
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("Error", error.message);
          this.info = null;
        });
    },
    getUserWithUsernameAndEmail() {
      axios
        .get(`http://localhost:4000/api/users/?username=${this.username}&email=${this.email}`)
        .then((response) => {
          console.log(response.data);
          this.userID = response.data.id
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