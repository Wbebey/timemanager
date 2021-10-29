<template>
  <div>
      <p>WorkingTimes Component !</p>
      <create-working-times />
      <show-working-times />
      <update-working-times />
      <delete-working-times />
  </div>
</template>

<script>
import axios from "axios";
import CreateWorkingTimes from './WorkingTime/CreateWorkingTime.vue'
import ShowWorkingTimes from './WorkingTime/ShowWorkingTime.vue'
import UpdateWorkingTimes from './WorkingTime/UpdateWorkingTime.vue'
import DeleteWorkingTimes from './WorkingTime/DeleteWorkingTime.vue'

export default {
  name: 'WorkingTimes',
  components: {
    CreateWorkingTimes,
    ShowWorkingTimes,
    UpdateWorkingTimes,
    DeleteWorkingTimes
  },
  data() {
    return {
      userId: null,
      workingTimes: null,
    };
  },
  methods: {
    getWorkingTimes() {
      axios
        .get(
          "http://localhost:4000/api/workingtimes/" + this.userId + "?start=" + this.start + "&end=" + this.end
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