import React from 'react'

import { useState} from 'react';
import {Link} from 'react-router-dom';
import { FaChevronUp, FaChevronDown } from 'react-icons/fa'
import { MdOutlineAdd } from 'react-icons/md'

import CatalogInf from './CatalogInf';

import classes from './../../styles/CatalogMainPage.module.css';



const CatalogMainPage = (props) => {

    const [data, setdata] = useState(CatalogInf); // хуки - функции которые помогают обрабатывать события в js
    const [order, setorder] = useState("ASC");  // assending - возрастающий
   
    const sorting = (col) => {
        if (order === "ASC") {
            const sorted = [...data].sort((a, b) =>
                a[col].toLowerCase() > b[col].toLowerCase() ? 1 : -1  
            );
            setdata(sorted);
            setorder("DSC");
        }

        if (order === "DSC") {
            const sorted = [...data].sort((a, b) =>
                a[col].toLowerCase() < b[col].toLowerCase() ? 1 : -1
            );
            setdata(sorted);
            setorder("ASC");
        }

    };

    //Sort
    const [upOrDownPrice, setUpOrDownPrice] = useState(false);
    const [upOrDownName, setUpOrDownName] = useState(false);
  
    const handleClickPrice = () => {
        sorting("price");
        setUpOrDownPrice(current => !current++);
    }

    const handleClickName = () => {
        sorting("name");
        setUpOrDownName(current => !current);
    } 

    const [value, setValue] = useState('');

    const filteredCatalog = data.filter(catal => {
        return catal.name.toLowerCase().includes(value.toLowerCase())
    })

    const itemClickHandler = e => {
        setValue(e.target.textContent)
        setIsOpen(!isOpen)
    }

    const [isOpen, setIsOpen] = useState(true)

    const inputClickHandler = () => {
        setIsOpen(true)
    }

    let delay = 100;
    let refInputSearch = React.createRef(); 

    return (
        <>
        <div className={classes.container}>

             <div className={classes.options}>

                <div className={classes.findBlock}>

                    <form>

                        <input 
                            type='text'
                            placeholder='Search'
                            className={classes.searchInput}
                            onChange={ event => setValue(event.target.value/*данные в input */)}
                            value={value} 
                            onClick={inputClickHandler}
                            ref={refInputSearch}
                            onKeyPress = {(event) => {
                                if(event.key === '`'){
                                    event.preventDefault();
                                    refInputSearch.current.value = setValue(''); //использование рефов
                                  }
                            }}
                        />

                        <ul className={classes.autocomplete}>
                            {
                                value && isOpen
                                    ? filteredCatalog.map( (item) => {
                                        return (
                                            <li className={classes.item} onClick={itemClickHandler} key={item.id}>
                                                {item.name}
                                            </li>
                                        )
                                    })
                                    : null
                            }
                             {}
                           
                        </ul>
                    

                    </form>

                </div>

                <div className={classes.words}>

                    <div onClick={handleClickName}>
                        <p className={classes.name}>Название</p>{upOrDownName ? <FaChevronUp /> : <FaChevronDown />}
                    </div>       

                    <div onClick={handleClickPrice}>
                        <p className={classes.price}>Цена</p>{upOrDownPrice ? <FaChevronUp /> : <FaChevronDown />}
                    </div>
                </div>   

            </div>


            <div className={classes.catalog}>   

                {filteredCatalog.map( (item) =>  (
                    <div className={classes.block} key={item.id}>
                        
                       <MdOutlineAdd className={classes.add} onClick={ () => props.onAdd(item)}/>

                        <Link to={item.path} className={classes.linkBlockFRS}>
                            <div className={classes.first}>
                                <img src={item.image} className={classes.catalogPhoto} alt='catalogPhoto'/>
                            </div>
                        </Link>

                        
                        
                        <div className={classes.text}>
                            <Link to={item.path} className={classes.linkBlockSec}>
                                <p className={classes.pInLink}>
                                    {item.name}
                                </p>
                            </Link>
                            <p>{item.price}</p>
                        </div>

                        <div className={classes.hideBlock}>{delay += 50}</div>

                    </div>
                ) )} 
            </div>

        </div>
        </>
    );
}


export default CatalogMainPage;

