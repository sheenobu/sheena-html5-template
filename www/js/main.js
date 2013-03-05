
function loadTestData(self) {
  $.get("/data.yml",function(data) {
    data = jsyaml.safeLoad(data);

    self.todos(data.todos);
  });
}

function SampleViewModel() {
  var self = this;
  self.todos = ko.observableArray([]);

  // if test {
    loadTestData(self);
  //}

  Sammy(function() {

  }).run();
}

ko.applyBindings(new SampleViewModel());
