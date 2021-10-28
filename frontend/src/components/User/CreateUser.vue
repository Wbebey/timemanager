<template>
  <div>
      <p>Create User Component !</p>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'CreateUser',
  data() {
    return {
      info: null,
      username: null,
      email: null,
    };
  },
  methods: {
    createUser() {
      axios
        .post(
          "http://localhost:4000/api/users?email=" + this.email + "&username=" + this.username
        )
        .then((response) => (this.info = response.data))
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