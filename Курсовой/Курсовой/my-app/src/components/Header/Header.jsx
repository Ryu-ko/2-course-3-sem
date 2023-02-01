import React from 'react';
import  classes from  '../../styles/header.module.css'
import { BsBoxSeam } from 'react-icons/bs'

import { Link } from 'react-router-dom';

import Order from '../Order'
import {useState} from 'react'


const showOrders = (props) => {
    let summa = 0;
    props.orders.forEach(el => summa += (Number.parseInt(el.price)))
    

    return(
        <>
            <div className={classes.myorders}>
                <div className={classes.myorders2}>
                    {props.orders.map(el => (
                        <Order onDelete={props.onDelete} key={el.id} item={el}/>
                    )) }
                </div>
            </div>
            <p className={classes.summa}>Итого: {summa.toFixed(0)} руб.</p>
        </>
      
    );
}

const showNothing = () => {
    return(
        <div className={classes.empty}>
            <h2>В вашей корзине пока пусто</h2>
        </div>
    );
}

export const Header = (props) => {

    let [cartOpen, setCartOpen] = useState(false)

    return(
        <div className={classes.HdrCont}>

            <h1 className={classes.Name}>woodley</h1>

            <div className={classes.comp}>

                <div className={classes.Icons}>
                   
                 
                </div>
            
                <div className={classes.txt}>
                    <Link to="/" className={classes.links}>Главная</Link>
                    <Link to="/Catalog" className={classes.links}>Каталог</Link>
                    <Link to="/AboutUS" className={classes.links}>О нас</Link>
               
                </div>



                <div className={classes.Iconsss}> 

                <BsBoxSeam className={`${classes.cart} ${cartOpen && classes.active}`} onClick={ () => setCartOpen(cartOpen = !cartOpen)}/>
                {/*если cartOpen true */}  
                             {cartOpen && ( 

                                <div className={classes.shopCart}>
                                    {props.orders.length > 0 ? 
                                        showOrders(props) : showNothing()}
                                </div>

                            )}
                                      
                </div>
            </div>

        </div>
    );
};

export default Header;

