import React from 'react';
import sofa from '../../img/main/yelSff.png'
import '../../styles/MainPage.css'
import { Link } from 'react-router-dom';
import '../../styles/MediaMainPage.scss'


export const MainBlc = () => {
    return(
        <div className="MainDv">
            
            <div className="Left">
                <h1>Мебель которую все <br/> Любят</h1>
                
                <p>Более +1000 заказов и положительных отзывов</p>
                
                <p> Cмотри и заказывай сейчас!</p>

                <Link to="/Catalog" ><button>Каталог</button></Link>
                <Link to="/AboutUS" ><button>О нас</button></Link>
                

            </div>

            <div className="Right">

            <Link to="/NymoYellowSofa" className='LinksMainDV'> 
            < img src={sofa} className="Sofa">

            </img>
            
                <h2>Диван Нумо Velvet Yellow</h2>
                
                <p>218×95×90 см</p>
                <p>1187 руб.</p>
            </Link>
                
            </div>
        </div>

    );
};

export default MainBlc;

/*15% <p>1937 руб.</p> */