<template>
  <div>
      <p>Update User Component !</p>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'UpdateUser',
  data() {
    return {
        info: null,
        username: null,
        email: null,
    };
  },
  methods: {
    updateUser() {
      axios
        .get(
          "http://localhost:4000/api/users/" + this.userID + "&username=" + this.username + "&email" + this.email
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