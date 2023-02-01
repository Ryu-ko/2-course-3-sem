
import './App.css';
import Header from  './components/Header/Header';
import React from 'react';
import Home from './Home';  
import AboutUS from './AboutUS';
import {Routes,Route} from 'react-router-dom';
import { Footer } from './components/Footer/Footer';
import CatalogInf from './components/Catalog/CatalogInf';
import CatalogMainPage from  './components/Catalog/CatalogMain';
import CatalogInfPage from './components/Catalog/CatalogInfPage';


export class App extends React.Component {

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
    <div className="AppContainer">  
    <Header orders={this.state.orders} onDelete={this.deleteOrder}/>   
      <Routes>
        
        <Route  path="/" element={<Home/>}/>
        <Route  path="/Catalog" element={<CatalogMainPage onAdd={this.addToOrder} />}/>
        <Route  path="/AboutUS" element={<AboutUS/>}/>

        <Route path={CatalogInf[0].path} element={<CatalogInfPage onAdd={this.addToOrder} allObj={CatalogInf[0]} />} />
        <Route path={CatalogInf[1].path} element={<CatalogInfPage onAdd={this.addToOrder}  allObj={CatalogInf[1]}/>} />
        <Route path={CatalogInf[2].path} element={<CatalogInfPage onAdd={this.addToOrder} allObj={CatalogInf[2]} />} />
        <Route path={CatalogInf[3].path} element={<CatalogInfPage onAdd={this.addToOrder} allObj={CatalogInf[3]}/>} />        
        <Route path={CatalogInf[4].path} element={<CatalogInfPage onAdd={this.addToOrder} allObj={CatalogInf[4]}/>} />
        <Route path={CatalogInf[5].path} element={<CatalogInfPage onAdd={this.addToOrder} allObj={CatalogInf[5]} />} />
        <Route path={CatalogInf[6].path} element={<CatalogInfPage onAdd={this.addToOrder} allObj={CatalogInf[6]}/>} />
        <Route path={CatalogInf[7].path} element={<CatalogInfPage onAdd={this.addToOrder} allObj={CatalogInf[7]} />} />
        <Route path={CatalogInf[8].path} element={<CatalogInfPage onAdd={this.addToOrder} allObj={CatalogInf[8]}/>} />        
      
      </Routes>
    <Footer />
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


export default App;
