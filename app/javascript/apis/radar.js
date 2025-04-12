const API_KEY = 'prj_test_pk_b9affe5ff9b78eb78b7703696b95f689df9d7fc4';

export async function init(onClickFunction, container = 'radar-autocomplete') {
  Radar.initialize(API_KEY);
  Radar.ui.autocomplete({
    container: container,
    width: '600px',
    debounceMS: 300,
    minCharacters: 3,
    showMarkers: false,
    limit: 5,
    onSelection: (address) => {
      onClickFunction(address);
    }
  });
}



