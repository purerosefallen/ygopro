--高速决斗技能-香水战术
Duel.LoadScript("speed_duel_common.lua")
function c100730045.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730045.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730045.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EVENT_ADJUST)
	e1:SetOperation(c100730045.adjustop)
	Duel.RegisterEffect(e1,tp)
end

function c100730045.adjustop(e,tp)
	local g=Duel.GetDecktopGroup(tp,1)
	if not g or g:GetCount()==0 then return end
	local fc=g:GetFirst()
	if fc:IsPosition(POS_FACEUP_DEFENSE) then return end
	fc:ReverseInDeck()
end