import React from 'react'
import '../../styles/About_Us.css'
import diamnd from '../../img/about/icons/dimond.svg'
import car from '../../img/about/icons/car.svg'
import hot from '../../img/about/icons/Hot.svg'
import fabric from '../../img/about/icons/fabric.svg'
import qual from '../../img/about/icons/qual.svg'

import bldvimg from '../../img/about/12.jpg'
import yeldvimg from '../../img/about/13.jpg'

import ex1 from '../../img/about/36.jpg'
import ex2 from '../../img/about/33.png'
import ex3 from '../../img/about/34.jpg'
import ex4 from '../../img/about/35.jpg'
import ex5 from '../../img/about/6.jpg'
import ex6 from '../../img/about/4.jpg'
import ex7 from '../../img/about/5.jpg'



export const About_Us = () => {
    return( 
        <div className='MainDv3'>
            <div className='About3'>
                <div className='Aboutblock3'>
                <p className='PAbCompZag'>О компании</p>

                <p className='PAbCompZagTXT'>
                Мы делаем надежную, стильную и функциональную мебель и продаем ее напрямую по выгодным ценам, без лишних наценок и переплат.
                </p>

                <div className='imgs'>
                    <figure>
                        <img src={diamnd}></img>
                        <figcaption>
                        15 лет собственное производство
                        </figcaption>
                    </figure>

                    <figure>
                        <img src={fabric}></img>
                        <figcaption>
                        Большой выбор тканей
                        </figcaption>
                    </figure>



                    <figure>
                        <img src={hot}></img>  
                            <figcaption>
                            Большое количество выгодных предложений 
                            </figcaption>
                    </figure>

                    <figure>
                        <img src={qual}></img>
                        <figcaption>
                        5 лет гарантии по договору
                        </figcaption>
                    </figure>
                    
                    <figure>
                        <img src={car}></img>
                        <figcaption>
                        Надежная доставка за короткие сроки 
                        </figcaption>
                    </figure>

                    </div>
                </div>
            </div>



            <div className='blk3'>
                <div className='blocks3'>
                    <div className='Bluedv'>
                        <div>
                            <div className='textblueDv'>
                                <h3>Объединяем все нужное</h3>
                        
                                <p>
                                    Актуальный ассортимент позволит легко обустроить любую комнату. Мягкая мебель с лаконичным европейским дизайном, коллекция кроватей с трендовыми обивками и товары для сна собственной марки, стильные системы хранения, современные решения для кухонь и студий. Все для дома — в одном месте!
                                </p>
                            </div>
                        </div>

                        <img src={bldvimg}></img>
                    </div>


                    <div className='Yellowdv'>

                        <img src={yeldvimg}></img>

                        <div>
                            <div className='textYelDv'>
                                <h3>Материалы</h3>
                            
                                <p>
                                    Дерево — прочный натуральный материал, который мы используем для изготовления самых разных конструкций: от каркасов мягкой мебели до ручек бельевых шкафов. Древесные производные (фанера, ДСП, МДФ), которые также применяются в производстве мебели, сертифицированы и имеют высший класс безопасности.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



            <div className='AbtExamples'>
                <h2>Примеры наших работ</h2>

                <div className="ExamplesDV">
                    <img src={ex1} className='exmpimg1'></img>
                    <img src={ex2} className='exmpimg2'></img>
                    <img src={ex3} className='exmpimg3'></img>
                    <img src={ex4} className='exmpimg4'></img>
                    <img src={ex5} className='exmpimg5'></img>
                    <img src={ex6} className='exmpimg6'></img>
                    <img src={ex7} className='exmpimg7'></img>
                </div>
            </div>
            
        </div>
        
        )
}

export default About_Us;