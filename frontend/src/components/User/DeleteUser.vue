<template>
  <div>
    <v-card elevation="2" class="d-inline-flex pa-2" outlined tile>
      <v-text-field label="User ID" class="mx-auto pa-6" v-model="userID"></v-text-field>
      <v-btn elevation="2" outlined color="accent" v-on:click="deleteUser()"
        >Delete user</v-btn
      >
    </v-card>
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