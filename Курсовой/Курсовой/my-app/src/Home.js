import MainBlc from  './components/mainPg/MainDV';
import Slider from  './components/mainPg/Slider';
import Note from  './components/mainPg/Note';

import './styles/Home.css'


function Home() {
  return (
    <div className="MainPage">
        <MainBlc />
        <Slider />
        <Note />
    </div>
  );
}

export default Home;
