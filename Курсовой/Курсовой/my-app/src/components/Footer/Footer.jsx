import React from 'react';
import '../../styles/footer.css'

import tg from '../../img/main/icon/telegram.svg'
import inst from'../../img/main/icon/instagram.svg'
import vk from '../../img/main/icon/vk.svg'

export const Footer = () => {

    return(
        <div className="FotrCont">
            <div className='SocMedia'>
            <a href="https://web.telegram.org/k/"><img src={tg} className='icon'></img></a>
            <a href="https://www.instagram.com/"><img src={inst} className='icon'></img></a>
            <a href="https://vk.com"><img src={vk} className='icon'></img></a>

            </div>

            <div className='CaptFooter'>
                <p>
                    Сайт выполнен в качестве  курсового проекта студенткой 2 курса ИСиТ Шишовой Т. С.
                </p>
            </div>
            
        </div>
    );
};

export default Footer;

