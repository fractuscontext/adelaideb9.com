<script setup lang="ts">
import SocialMedia from '../components/SocialMedia.vue';
import Ticket from '../components/Ticket.vue';
import { computed, onMounted, ref } from "vue";
import http from "../services/http";

import { useStore } from 'vuex';
import TicketSmall from '../components/TicketSmall.vue';
//const store = useStore();

let ctfs = ref([]);
let events = ref([]);
let loaded = ref(false);
let upcomingNumber = ref(null)

onMounted(async () => {
  http.get("/api/ctfs").then((res=>{
    ctfs.value = res.data.map(i=>Object.assign(i,{type:"ctf"}));
    loaded.value = true;
  }));
  http.get("/api/events").then((res=>{
    events.value = res.data.map(i=>Object.assign(i,{type:"event"}));
    loaded.value = true;
  }));
});

const combinedEvents = computed(() => {
  // Merge results
  let result = Object.assign(ctfs.value,events.value);

  // Time Filter
  let now = new Date()
  result = result.filter(i=>now <= new Date(i.date) || now <= new Date(i.end_date));

  upcomingNumber.value = result.length;

  // Sort soonest first
  return result.sort((a, b)=>new Date(a.date) - new Date(b.date)).slice(0,3);
});

</script>

<template>
<div>
  <div
    class="min-h-screen py-20 -mt-20 flex content-center justify-center items-center gap-12 flex-col-reverse lg:flex-row"
  >
    <div class="space-y-5 mx-10 lg:mx-0 text-lg">
      <h1>We're AdelaideB9 </h1>
      <p class="lg:w-[34rem]">
        Adelaide University's competitive cybersecurity team. We win
        prizes for pwning servers, reverse-engineering binaries, performing
        forensics on unusually large JPEGs, and much, much more.<br /><br />

        If you're a South Australian student who thinks this sounds interesting,
        come join us! We'd love to have you.<br/><br/>
      </p>


      <div class="flex flex-row flex-wrap items-center justify-start gap-4 max-w-fit">
        <SocialMedia
          src="/img/social/discord-brands.svg"
          href="https://discord.gg/M3x2Bkbb3N"
          :join="true"
          class="h-[50px] flex items-center" 
        />
        
        <router-link class="no-underline text-s" to="/register">
          <div class="flex items-center justify-center backdrop-filter bg-black/10 rounded-md h-[50px] px-10 hover:brightness-95 transition-all">
            <p class="font-medium tracking-tighter text-center m-0 flex items-center gap-2 text-nowrap">
              Register
              <img src="/img/icons/external-link-dark.svg" class="w-4 h-4 inline"/>
            </p>
          </div>
        </router-link>
      </div>
    </div>
    <img src="/img/logo.png" class="w-96" />
    <br/>
  </div>
<div v-if="combinedEvents.length >= 1 && loaded" class="py-20 -mt-20 flex content-center justify-center items-center gap-12 flex-col-reverse lg:flex-row">
    <div class="space-y-5 text-lg">
      <h1 class="text-center" >Upcoming Events</h1>
      <div v-if="combinedEvents.length >= 1 && loaded" class="flex flex-col gap-6">
        
        <!-- FIX: use 'flex flex-col gap-4' to separate individual cards -->
        <div class="flex flex-col gap-4">
          <TicketSmall
            v-for="v of combinedEvents"
            :key="v.ID"
            :details="v"
          />
        </div>
        <div class="w-full">
          <a class="text-center block cursor-pointer block rounded-2xl border-solid border-black/5 border-2 bg-white/25 no-underline shrink py-4 px-12 m-auto w-max" href="/events">See all <span v-if="upcomingNumber > 3" class="text-sm opacity-75">[{{ upcomingNumber }}]</span></a>
        </div>
      </div>
      <!-- div v-if="combinedEvents.length < 1 || loaded">
        <Ticket
          :key="combinedEvents[0].ID"
          :details='{"date": "2025-03-03T00:00:00Z", "description": "", "end_date": "2025-04-01T22:00:00Z", "id": 7, "name": "Weekly 2025", "url": "https://weekly.adelaideb9.com/"}'
        />
        <a class="mt-8 text-center block cursor-pointer" href="/events">See all</a>
      </div -->
    </div>
  </div>
</div>
</template>
