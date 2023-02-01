import React from 'react';
import '../../styles/Slider.css'
import { Swiper, SwiperSlide } from "swiper/react";
import "swiper/css";
import "swiper/css/pagination";
import "swiper/css/navigation";
import { Pagination, Navigation } from "swiper";
import Ferran from '../../img/catalog/Ferran.jpg';
import Nordik from '../../img/catalog/Nordik.jpg';
import Oksford from '../../img/catalog/oksford.jpg';
import Modern from '../../img/catalog/Modern.jpg';
import TilarDv from '../../img/catalog/TilarDv.jpg';
import VienaDv from '../../img/catalog/VienaDv.jpg';

import { Link } from 'react-router-dom';
export const Slider = () => {
    return(
        <div className="SliderBlock">
            <h3>Новинки</h3>

            <div className="mySwiper">
                    
                <Swiper
                    slidesPerView={3}
                    spaceBetween={90}
                    slidesPerGroup={3}
                    loop={true}
                    loopFillGroupWithBlank={true}
                    pagination={{
                        clickable: true,
                    }}
                    navigation={true}
                    modules={[Pagination, Navigation]}                 
                >
                    <SwiperSlide> <Link to="/Modern" > <img src={Modern}/> </Link></SwiperSlide>
                    <SwiperSlide><Link to="/TilarDv" > <img src={TilarDv}/> </Link></SwiperSlide>
                    <SwiperSlide><Link to="/Oksford" > <img src={Oksford}/> </Link></SwiperSlide>
                    <SwiperSlide><Link to="/Ferran" > <img src={Ferran}/> </Link></SwiperSlide>
                    <SwiperSlide><Link to="/Nordik" > <img src={Nordik}/> </Link></SwiperSlide>
                    <SwiperSlide><Link to="/VienaDv" > <img src={VienaDv}/> </Link></SwiperSlide>

                </Swiper>
      
            </div>
        </div>
    );
};

export default Slider;