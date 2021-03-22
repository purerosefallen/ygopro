--高速决斗技能-超能力决斗者
Duel.LoadScript("speed_duel_common.lua")
function c100730163.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730163.skill,c100730163.con,aux.Stringid(100730163,0))
	local e1=Effect.GlobalEffect()
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCondition(c100730163.con)
	e1:SetOperation(c100730163.skill)
	Duel.RegisterEffect(e1,tp)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730163.con(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()	
end

function c100730163.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730163)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(1-tp,1,nil)
	local tc=g:GetFirst()
	if not tc then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	local op=Duel.AnnounceType(tp)
	Duel.ConfirmCards(tp,tc)
	Duel.ShuffleHand(1-tp)
	if (op==0 and tc:IsType(TYPE_MONSTER)) or (op==1 and tc:IsType(TYPE_SPELL)) or (op==2 and tc:IsType(TYPE_TRAP)) then
		Duel.Damage(1-tp,500,REASON_RULE)
	end
end