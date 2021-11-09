--高速决斗技能-反转痛苦
Duel.LoadScript("speed_duel_common.lua")
function c100730059.initial_effect(c)
	aux.SpeedDuelAtMainPhaseNoCountLimit(c,c100730059.skill,c100730059.con,aux.Stringid(100730059,0))
	aux.RegisterSpeedDuelSkillCardCommon()
	if not c100730059.battle_damage then
		c100730059.battle_damage={}
		c100730059.battle_damage[0]=0
		c100730059.battle_damage[1]=0
		c100730059.battle_damage[2]=0
		c100730059.battle_damage[3]=0
	end
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetOperation(c100730059.damcal)
	Duel.RegisterEffect(e1,0)
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetOperation(c100730059.damcalreset)
	Duel.RegisterEffect(e2,0)
end

function c100730059.damcal(e,tp,eg,ep,ev,re,r,rp)
	c100730059.battle_damage[ep]=c100730059.battle_damage[ep]+ev
end

function c100730059.damcalreset(e,tp,eg,ep,ev,re,r,rp)
	c100730059.battle_damage[2]=c100730059.battle_damage[0]
	c100730059.battle_damage[3]=c100730059.battle_damage[1]
	c100730059.battle_damage[0]=0
	c100730059.battle_damage[1]=0
end

function c100730059.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and c100730059.battle_damage[tp+2]>0
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil)
end

function c100730059.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_SELECTMSG,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	if not g or g:GetCount()==0 then return end
	local fc=g:GetFirst()
	local e1=Effect.GlobalEffect(fc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(math.floor(c100730059.battle_damage[tp+2]/2))
	fc:RegisterEffect(e1)
end