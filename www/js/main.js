
function loadTestData(self) {
  $.get("/data.yml",function(data) {
    data = jsyaml.safeLoad(data);

    self.todos(data.todos);
  });
}

function loadEnvData(s) {
  s.test = ko.observable();
  s.test(false); 

  $.get("/env.yml", function(data) {
    data = jsyaml.safeLoad(data);
    
    s.test(data.test);
  });
}

function SampleViewModel() {
  var self = this;
  self.todos = ko.observableArray([]);

  loadEnvData(self);
  
  if(self.test()){
    loadTestData(self);
  }

  self.view = ko.observable();

  self.to = function(id) {
    self.view(id);
  }

  self.to('home');

}

ko.applyBindings(new SampleViewModel());
