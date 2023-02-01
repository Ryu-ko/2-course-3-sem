import React from 'react';
import classes from '../styles/OrderPage.module.css'
import {BiTrash} from 'react-icons/bi'

const Order = (props) => {
        return(
            <div className={classes.item}>
                <img src={props.item.image} alt='albumPhoto'/>
                <h3 className={classes.pInLink}>{props.item.name}</h3>
                <p>{props.item.price}</p>
                <BiTrash className={classes.deleteIcon} onClick={ () => props.onDelete(props.item.id)}/>
            </div>
        );
}

export default Order;