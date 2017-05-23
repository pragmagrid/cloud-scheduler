import style from './map.scss'
import React,{Component} from 'react'

const OPTIONS = {
    center: {
        lat: 48.873947,
        lng: 2.295038
    },
    zoom: 2,
    minZoom: 2,
    maxZoom: 11,  
    backgroundColor: '#191E2C',
    scaleControl: true,
    disableDefaultUI: false,
    streetViewControl: false,
    mapTypeControl: false,
    zoomControl: false,
        styles: [{
            featureType: 'water',
            stylers: [{ color: '#191E2C' }]
        },{
            featureType: 'landscape',
            stylers: [{ color: '#3D4153' }]
        },{
            featureType: 'poi',
            stylers: [{ color: '#4E5265' }]
        },{
            featureType: 'all',
            elementsType: 'all',
            stylers: [{ visibility: 'off'}]
        },{
            featureType: 'water',
            elementsType: 'geometry',
            stylers: [{ visibility: 'on'}]
        },{
            featureType: 'landscape',
            elementsType: 'geometry',
            stylers: [{ visibility: 'on'}]
        },{
            featureType: 'administrative.country',
            elementsType: 'geometry.stroke',
            stylers: [{ visibility: 'off'}]
        }]
}

export default class map extends Component {
    componentDidMount(){
        this.props.container.showMap(this.refs.map,OPTIONS)
    }

    render() {
        let {search,minZoom,maxZoom,nowZoom,timezone} = this.props.container.state
        let timezoneLabel =  this.props.container.state.timezone.split(' ')
        let cancelIcon
        if(search!=''){
            cancelIcon = <img className={style.cancelicon} src='img/ic_cancel_circle_white.svg' onClick={this.props.container.onClearSearch}/>
        }
        return (
            <section id={style.map}>
                <div className={style.timezone}>
                    <div className={style.wrap}>
                        <img className={style.icon} src='img/ic_access_time.svg'/>
                        <div className={style.text}>
                            <div className={style.time}>{this.props.container.state.date}</div>
                            <div className={style.utc}>{timezoneLabel[0]+' '+timezoneLabel[1]+' '+timezoneLabel[2]}</div>
                        </div>
                    </div>
                </div>
                <div className={style.search}>
                    <img  className={style.searchicon} src='img/ic_search_input.svg'/>
                    <input type='text' placeholder='Search by name' className={style.input} value={this.props.container.state.search} onChange={this.props.container.onSearchChange} onKeyPress={this.props.container.onSearchPress}/>
                    {cancelIcon}
                </div>
                {this.props.container.state.autocompletePanel}

                <div className={style.zoomcontrol}>
                    <div className={style.zoombtn} onClick={this.props.container.onZoomOut}><img className={style.icon} src='img/ic_remove.svg'/></div>
                    <input className={style.zoomslider} type='range' min={minZoom} max={maxZoom} value={nowZoom} onChange={this.props.container.onZoomSliderChange}/>
                    <div className={style.zoombtn} onClick={this.props.container.onZoomIn}><img className={style.icon} src='img/ic_add.svg'/></div>
                </div>
                <div className={style.display} ref="map"></div>
            </section>
        )
    }
}
