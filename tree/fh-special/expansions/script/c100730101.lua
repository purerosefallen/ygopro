--高速决斗技能-祭品的力量
Duel.LoadScript("speed_duel_common.lua")
function c100730101.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730101.skill)
	local e3=Effect.GlobalEffect()
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PREDRAW)
	e3:SetOperation(c100730101.operation)
	e3:SetLabel(10000090)
	e3:SetLabelObject(c)
	Duel.RegisterEffect(e3,0)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730101.operation(e,tp,eg,ep,ev,re,r,rp)
	local id=e:GetLabel()
	tp = e:GetLabelObject():GetOwner()
	local c=Duel.CreateToken(tp,id)
	Duel.SendtoGrave(c,REASON_RULE)
	e:Reset()
end

function c100730101.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetHandler()
	--tribute check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e1:SetValue(c100730101.valcheck)
	Duel.RegisterEffect(e1,tp)
	--give atk effect only when summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SUMMON_COST)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetTarget(c100730101.tgchk)
	e2:SetOperation(c100730101.facechk)
	e2:SetLabelObject(e1)
	Duel.RegisterEffect(e2,tp)
	Duel.RegisterFlagEffect(tp,100424104,RESET_PHASE+PHASE_END,0,1)
	e:Reset()
end

function c100730101.valcheck(e,c)
	if e:GetLabel()==1 then
		e:SetLabel(0)
		local g=c:GetMaterial()
		local tc=g:GetFirst()
		local atk=0
		local def=0
		while tc do
			atk=atk+math.max(tc:GetTextAttack(),0)
			def=def+math.max(tc:GetTextDefense(),0)
			tc=g:GetNext()
		end
		--atk continuous effect
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
		c:RegisterEffect(e1)
		--def continuous effect
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENSE)
		e2:SetValue(def)
		c:RegisterEffect(e2)
	end
end
function c100730101.tgchk(e,c)
	return c:IsCode(10000010)
end
function c100730101.facechk(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(1)

end