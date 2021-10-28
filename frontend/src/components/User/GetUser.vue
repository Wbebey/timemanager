<template>
  <div>
      <p>Get User Component !</p>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'GetUser',
  data() {
    return {
        info: null,
        userID: null,
    };
  },
  methods: {
    getUser() {
      axios
        .get(
          "http://localhost:4000/api/users/" + this.userID
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