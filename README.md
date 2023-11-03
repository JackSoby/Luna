# Luna

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000/`](http://localhost:4000/) from your browser.


## Implimentation

Below is outlined how I completed the task at hand

### Data 
Created a table called `graph` with the following fields fields:
 ```
 url: Text
 image_url: Text
 status: String
 ```
 
### Front end 
I created a simple HTML form in my front end that is displayed at the `/` route, it takes in one entry which must be a url. This page also displays the result of all valid inputs into this form on the page below. 

### Controllers
I created a controller call `upload_controller` which has two actions inside of it, an `index` action and a `create` action. The index action queries all of the created URLs and passes them to the index.html file. The create action takes in a new url, creates a new graph with a status of pending, and asynchronously starts the url processesing process. 

### URL Processing
Once a Graph is created, we asynchronously pass it to a function called `Luna.OpenGraphManagement.process_url/1` This function takes the Graph and makes a `get` request to the url present on the graph using `finch`. If that endpoint does not exist, we update the URL status to failed. If it does exist we then process the response with the `opengraph_parser` library to extract the graph values. If it has an image_url, we update the Graph to have an image url and a status of success, otherwise, we set the status to failed.

### Updating The Front End
Once we have a result from updating our Graph with its new status and possible image_url, we update the frontend using Phoenix Sockets and Channels. We broadcast a message to the `open_graph_room:lobby` with the message called `open_graph_update` passing along the params like so 
```
    LunaWeb.Endpoint.broadcast("open_graph_room:lobby", "open_graph_update", %{
      image_url: url,
      status: status,
      id: id
    })
```

We then receive this message in the front end and update our HTML with the new status and possible image url like so 
```
  channel.on('open_graph_update', msg => {
    var statusDiv = document.getElementsByClassName(`pending ${msg.id}`)[0];

    if(statusDiv){
      statusDiv.className = `${msg.status} ${msg.id}`
      statusDiv.innerHTML = msg.status
    }
    
    if(msg.status != "failed") { 
      var imageDiv  = document.getElementsByClassName(`image ${msg.id}`)[0];
      if(imageDiv){
          imageDiv.innerHTML =`<img src="${msg.image_url}" >`;
        }
      }
  })
```

### Hangups
My biggest hangup was around URLs that did not exist or have open graph data. These URLs would process to fast and the socket could not update the front end in time before refresh. My solution was to wait half of a second when kicking off the async task of url processing:
```
Task.async(fn ->
  Process.sleep(400)
  OpenGraphManagement.process_url(open_graph)
end)
```
I think thre could be a better work around but I was spinning my wheels to long on this part so went with this solution. Also using a front end framework like LiveView or React could help prevent this issue from popping up. 

### Thoughts
The reason I did not use something like LiveView for this project was out of simplicity's sake. It would be overkill for one webpage that has a one input form. I decided to use Sockets because it is a really nice clean way Phoenix provides for sending updates to the front end from the server. It felt like this project was made for Sockets. It is also one of my favorite features of Phoenix and always fun to use!

    

