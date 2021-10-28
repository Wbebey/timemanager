<template>
  <div>
      <p>Update WorkingTime Component !</p>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'UpdateWorkingTime',
  data() {
    return {
        info:null,
        id: null,
    };
  },
  methods: {
    updateWorkingTime() {
      axios
        .put(
          "http://localhost:4000/api/workingtimes/" + this.id
        )
        .then((response) => (this.info = response.data))
        .catch((error) => { console.log('Error', error.message); this.info = null;
        });
    },
    deleteWorkingTime() {
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