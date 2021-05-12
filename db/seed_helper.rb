module SeedHelper
  def cars
    return [
      {
        brand: 'Maruti Suzuki',
        models: [
          {
            model: 'Dzire',
            variants: ['lxi', 'vxi', 'vxi(o)', 'zxi', 'zxi(o)']
          },
          {
            model: 'Swift',
            variants: ['lxi', 'vxi', 'vxi(o)', 'zxi', 'zxi(o)']
          },
          {
            model: 'Celerio',
            variants: ['lxi', 'vxi', 'vxi(o)', 'zxi', 'zxi(o)']
          },
        ],
      },
      {
        brand: 'Hundai',
        models: [
          {
            model: 'i10',
            variants: ['Era', 'Magna', 'Sportz', 'AMT Magna', 'Magna CNG', 'Sportz Dual Tone']
          },
          {
            model: 'i20',
            variants: ['Era', 'Magna', 'Sportz', 'AMT Magna', 'Magna CNG', 'Sportz Dual Tone']
          },
          {
            model: 'venue',
            variants: ['Era', 'Magna', 'Sportz', 'AMT Magna', 'Magna CNG', 'Sportz Dual Tone']
          }
        ],
      },
      {
      brand: 'Hundai',
        models: [
          {
            model: 'i10',
            variants: ['Era', 'Magna', 'Sportz', 'AMT Magna', 'Magna CNG', 'Sportz Dual Tone']
          },
          {
            model: 'i20',
            variants: ['Era', 'Magna', 'Sportz', 'AMT Magna', 'Magna CNG', 'Sportz Dual Tone']
          },
          {
            model: 'Venue',
            variants: ['Era', 'Magna', 'Sportz', 'AMT Magna', 'Magna CNG', 'Sportz Dual Tone']
          }
        ],
      },
    ]
  end 

  def bikes
    return [
      {
        brand: 'Bajaj',
        models: [
          {
            model: 'Dominar 400',
            variants: ['Dominar 400 BS6']
          },
          {
            model: 'Dominar 250',
            variants: ['Dominar 250 BS6']
          },
          {
            model: 'Pulsar 220F',
            variants: ['Pulsar 220F BS6']
          },
        ],
      },
      {
        brand: 'TVS',
        models: [
          {
            model: 'Apache RTR 160 4V',
            variants: ['Apache RTR 160 4V Drum', 'Apache RTR 160 4V Disc']
          },
          {
            model: 'Apache RTR 180 BS6',
            variants: ['Apache RTR 180 BS6']
          },
          {
            model: 'Apache RTR 200 4V',
            variants: ['Apache RTR 200 4V Single Channel ABS', 'Apache RTR 200 4V Dual Channel ABS']
          }
        ],
      },
      {
      brand: 'Royal Enfield',
        models: [
          {
            model: 'Classic 350',
            variants: ['Classic 350 STD', 'Classic 350 Pure Black', 'Classic 350 Signals Edition', 'Classic 350 Gunmetal Grey']
          },
          {
            model: 'Meteor 350',
            variants: ['Meteor 350 Fireball', 'Meteor 350 Stellar', 'Meteor 350 Supernova', ]
          },
          {
            model: 'Himalayan',
            variants: ['Gravel Grey', 'Mirage Silver', 'Lake Blue', 'Rock Red', 'Granite Black', 'Pine Green']
          }
        ],
      },
    ]
  end 

  def scooters
    return [
      {
        brand: 'TVS',
        models: [
          {
            model: 'Jupiter',
            variants: ['STD', 'ZX', 'Classic', 'ZX Disc with IntelliGo']
          },
          {
            model: 'Ntorq 125',
            variants: ['Ntorq 125 Drum', 'Ntorq 125 Disc', 'Ntorq 125 Race Edition']
          },
          {
            model: 'Scooty Zest',
            variants: ['Scooty Zest Gloss', 'Scooty Zest Matte Series']
          },
        ],
      },
      {
        brand: 'Honda',
        models: [
          {
            model: 'Activa 6G',
            variants: ['Activa 6G STD', 'Activa 6G 20th Year Anniversary Edition STD', 'Activa 6G DLX']
          },
          {
            model: 'Activa 125',
            variants: ['Activa 125 Drum', 'Activa 125 Drum Alloy', 'Activa 125 Disc']
          },
          {
            model: 'Dio',
            variants: ['Dio STD', 'Dio DLX', 'Dio Repsol Edition']
          }
        ],
      },
    ]
  end
end
