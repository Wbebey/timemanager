<template>
  <div>
      <p>Create WorkingTime Component !</p>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: 'CreateWorkingTime',
  data() {
    return {
      info:null,
      start: null,
      end: null,
    };
  },
  methods: {
    createWorkingTime() {
      axios
        .post(
          "http://localhost:4000/api/workingtimes/" + this.user.userID + "?start=" + this.start + "&end=" + this.end
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