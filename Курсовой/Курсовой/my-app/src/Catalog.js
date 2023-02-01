import React from 'react'

import classes from './styles/App.module.css';


export class Catalog extends React.Component  {
  constructor(props) {
    super(props)
    this.state = {
      orders: []
    }
    this.addToOrder = this.addToOrder.bind(this)
    this.deleteOrder = this.deleteOrder.bind(this)
    
  }
  render() {
    return (
      <div className={classes.container}>



      </div>
    );
}

  deleteOrder(id) {
    this.setState({orders: this.state.orders.filter(el => el.id !== id)})
  }
    


    addToOrder(item) {
      let isInArray = false;
      this.state.orders.forEach(el => {
        if(el.id === item.id)
          isInArray = true
      })

      if(!isInArray)
      this.setState({orders : [item, ...this.state.orders] })
    }
}


export default Catalog;



/*
        <Routes>
          <Route path='*' element={<CatalogMainPage  />} />

          <Route path={CatalogInf[0].path} element={<CatalogInfPage  allObj={CatalogInf[0]}  />} />
          <Route path={CatalogInf[1].path} element={<CatalogInfPage allObj={CatalogInf[1]}/>} />
         
          
        </Routes>


 <Route path={CatalogInf[2].path} element={<CatalogInfPage onAdd={this.addToOrder} allObj={CatalogInf[2]}  />} />
          <Route path={CatalogInf[3].path} element={<CatalogInfPage onAdd={this.addToOrder}  allObj={CatalogInf[3]}/>} />
          <Route path={CatalogInf[4].path} element={<CatalogInfPage onAdd={this.addToOrder} allObj={CatalogInf[4]}  />} />
          <Route path={CatalogInf[5].path} element={<CatalogInfPage onAdd={this.addToOrder}  allObj={CatalogInf[5]}/>} />
          <Route path={CatalogInf[6].path} element={<CatalogInfPage onAdd={this.addToOrder} allObj={CatalogInf[6]}  />} />
          <Route path={CatalogInf[7].path} element={<CatalogInfPage onAdd={this.addToOrder}  allObj={CatalogInf[7]}/>} />

*/