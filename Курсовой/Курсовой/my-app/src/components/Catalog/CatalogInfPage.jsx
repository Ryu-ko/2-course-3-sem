
import React from 'react';
import { Carousel } from 'react-responsive-carousel';
import "react-responsive-carousel/lib/styles/carousel.min.css"; // requires a loader


import classes from './../../styles/CatalogInfPage.module.css'

import './../../styles/None.css';


function CatalogInfPage(props) {
    return (

        <div className={classes.container}>
           
            <div className={classes.coversAndInf}>

                <div className={classes.covers}>

                    <Carousel className={classes.carous}>

                        <div className={classes.images}>
                            <img src={props.allObj.image} />
                        </div>

                        <div className={classes.images}>
                            <img src={props.allObj.image2} />
                        </div>

                        <div className={classes.images}>
                            <img src={props.allObj.image3} />
                        </div>

                        <div className={classes.images}>
                            <img src={props.allObj.image4} />
                        </div>

                    </Carousel>

                </div>

                <div className={classes.inf}>

                    <div className={classes.mainInf}>

                        <h2 className={classes.modelName}>

                            {props.allObj.modelName} 
                        </h2>

                        <p className={classes.name}>

                            {props.allObj.name} 
                        </p>

                        <p className={classes.article}>Артикль: {props.allObj.article}</p>
                        <p className={classes.price}>{props.allObj.price}</p>

                        <button className={classes.btn} onClick={ () => props.onAdd(props.allObj)}>Добавить в корзину</button>
                        
                    </div>

                        <div className={classes.description}>
                            <h4>Описание</h4>
                            <p>{props.allObj.description}</p>
                        </div>

                </div>
            </div>
            
            <div className={classes.СharacterObj}>
                
                    <div className={classes.СharacterIMG}>
                        <h4>Характеристика</h4>
                        <img src={props.allObj.characteristicImg} />
                    </div>

                    <div className={classes.СharacterObj}>
                        
                        <h4>Размеры:</h4>
                        
                        <p className={classes.sizes}> 
                        <b><u>Длина:</u></b> {props.allObj.width}  Х <b><u> Ширина:  </u></b>{props.allObj.length}  Х  <b><u>Высота: </u></b>{props.allObj.height}
                        </p>

                        <div className={classes.Сharacterss}>
                            <p><b><u>Основной материал:</u></b> {props.allObj.mainmaterial}</p>
                            <p><b><u>Опоры:</u></b> {props.allObj.opor}</p>

                            <p><b><u>Наполнение:</u></b> {props.allObj.filling}</p>
                            <p><b><u>Страна: </u></b>{props.allObj.country}</p>
                            <p><b><u>Стиль:</u></b> {props.allObj.style}</p>
                            <p><b><u>Основной цвет:</u></b>{props.allObj.mainColor}</p>
                            <p><b><u>Вариант доставки:</u> </b>{props.allObj.deliverType}</p>

                        </div>
                    </div>
            </div>

        </div>//container
    );
}

export default CatalogInfPage;
