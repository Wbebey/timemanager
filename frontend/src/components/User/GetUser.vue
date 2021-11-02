<template>
  <div>
    <v-card elevation="2" class="d-inline-flex pa-2" outlined tile>
      <v-text-field label="Adresse mail" class="mx-auto pa-6" v-model="email"></v-text-field>
      <v-text-field
        :rules="rules"
        hide-details="auto"
        label="Nom d'utilisateur"
        class="mx-auto pa-6"
        v-model="username"
      ></v-text-field>
      <v-btn elevation="2" outlined color="accent" v-on:click="getUserWithUsernameAndEmail()"
        >Get User</v-btn
      >
    </v-card>
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