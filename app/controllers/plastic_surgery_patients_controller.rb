class PlasticSurgeryPatientsController < ApplicationController

  def index
    @patients = PlasticSurgeryPatient.all
  end

  def show
    @patient = PlasticSurgeryPatient.find(params[:id])
  end

  def new
    @patient = PlasticSurgeryPatient.new
    
    # Calculates the latest record number for insertion
    record = PlasticSurgeryPatient.maximum(:record)
    @patient.record = record.nil? ? 0 : record + 1
    
    @patient.addresses.build
    @patient.evolutions.build
    @patient.patient_clinical_information = PatientClinicalInformation.new
    @patient.patient_histories.build
    @patient.patient_surgeries.build
    @patient.telephones.build
  end

  def edit
    @patient = PlasticSurgeryPatient.find(params[:id])
  end

  def create
    @patient = PlasticSurgeryPatient.new(params[:plastic_surgery_patient])

    if @patient.save
      flash[:notice] = 'Patient was successfully created.'
      redirect_to(@patient)
    else
      render :action => "new"
    end
  end

  def update
    # To overcome the bug of not editing/destroying associated nested attributes it is necessary
    # to load these associations when the patient is loaded
    # For more information see https://rails.lighthouseapp.com/projects/8994/tickets/4766-nested_attributes-fails-to-updatedestroy-when-association-is-loaded-between-setting-attributes-and-saving-parent
    @patient = Patient.find(params[:id], :include => [:evolutions, :addresses, :telephones])
    
    if @patient.update_attributes(params[:plastic_surgery_patient])
      flash[:notice] = 'Patient was successfully updated.'
      redirect_to(@patient)
    else
      render :action => "edit"
    end
  end

  def destroy
    @patient = PlasticSurgeryPatient.find(params[:id])
    @patient.destroy

    redirect_to(plastic_surgery_patients_url)
  end
  
end
