<template>
  <div>
      <p>User Component !</p>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'User',
  data() {
    return {
      firstname: null,
      lastname: null,
    };
  },
  methods: {
    createUser() {
      axios
        .get(
          "http://api.openweathermap.org/data/2.5/weather?q=" + this.city + "&appid=" + this.Apikey
        )
        .then((response) => (this.info = response.data))
        .catch((error) => { console.log('Error', error.message); this.info = null;
        });
    },
    updateUser() {
      axios
        .get(
          "http://api.openweathermap.org/data/2.5/weather?q=" + this.city + "&appid=" + this.Apikey
        )
        .then((response) => (this.info = response.data))
        .catch((error) => { console.log('Error', error.message); this.info = null;
        });
    },
    getUser() {
      axios
        .get(
          "http://api.openweathermap.org/data/2.5/weather?q=" + this.city + "&appid=" + this.Apikey
        )
        .then((response) => (this.info = response.data))
        .catch((error) => { console.log('Error', error.message); this.info = null;
        });
    },
    deleteUser() {
        axios
        .get(
          "http://api.openweathermap.org/data/2.5/weather?q=" + this.city + "&appid=" + this.Apikey
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