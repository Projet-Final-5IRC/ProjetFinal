﻿using Microsoft.AspNetCore.Mvc;
using ms_evt.Models.DTO;
using Newtonsoft.Json;
using System;
using System.Net;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace ms_evt.Services
{
    public class DataService
    {

        private readonly HttpClient _httpClient;

        public DataService(HttpClient httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;

            var apiBaseUrl = configuration.GetValue<string>("ConnectionStrings:BaseUrl");

            _httpClient.BaseAddress = new Uri(apiBaseUrl);
        }

        public async Task<List<EventDTO>> GetEventsAsync(string endpoint)
        {
            var response = await _httpClient.GetStringAsync(endpoint);
            return JsonConvert.DeserializeObject<List<EventDTO>>(response);
        }

        public async Task<EventDTO> GetEventByIdAsync(string endpoint,int id)
        {
            var response = await _httpClient.GetStringAsync($"{endpoint}/{id}");
            return JsonConvert.DeserializeObject<EventDTO>(response);
        }

        public async Task<HttpStatusCode> PostEventAsync(string endpoint, EventDTO data)
        {
            var content = new StringContent(JsonConvert.SerializeObject(data), System.Text.Encoding.UTF8, "application/json");
            var response = await _httpClient.PostAsync(endpoint, content);

            return response.StatusCode;
        }

        public async Task<HttpStatusCode> DeleteEventAsync(string endpoint, int id)
        {
            var response = await _httpClient.DeleteAsync($"{endpoint}/{id}");
            return response.StatusCode;
        }

        public async Task<HttpStatusCode> PutEventAsync(string endpoint, int id,EventDTO eventDTO)
        {
            var content = new StringContent(JsonConvert.SerializeObject(eventDTO), System.Text.Encoding.UTF8, "application/json");
            var response = await _httpClient.PutAsync($"{endpoint}/{id}",content);
            return response.StatusCode;
        }
    }
}
