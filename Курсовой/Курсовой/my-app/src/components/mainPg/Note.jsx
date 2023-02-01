import React from 'react';
import '../../styles/Note.css'
import kvch from '../../img/main/kvch.svg'
import { Link } from 'react-router-dom';


export const Note = () => {
    return(
        <div className="NoteBlock">

            <div className="BlockTxt">
                <img src={kvch} className="kvch"></img>            

                <p  className='p2'>
                    Наша цель — воплотить в жизнь ваши мечты об интерьере. Обустраивайте свой дом.
                    Создавайте обстановку, которая делает будни ярче!
                </p>
            </div>

            <div className='ButtonDv'>
                <Link to="/Catalog"><button>Каталог</button></Link>

            </div>

        </div>
    );
};

export default Note;
